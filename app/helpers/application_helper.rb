# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include AsuntosLib

# Yield the content for a given block. If the block yiels nothing, the optionally specified default text is shown.
  #
  #   yield_or_default(:user_status)
  #
  #   yield_or_default(:sidebar, "Sorry, no sidebar")
  #
  # +target+ specifies the object to yield.
  # +default_message+ specifies the message to show when nothing is yielded. (Default: "")
  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end

# Create tab.
  #
  # The tab will link to the first options hash in the all_options array,
  # and make it the current tab if the current url is any of the options
  # in the same array.
  #
  # +name+ specifies the name of the tab
  # +all_options+ is an array of hashes, where the first hash of the array is the tab's link and all others will make the tab show up as current.
  #
  # If now options are specified, the tab will point to '#', and will never have the 'active' state.
  def tab_to(name, all_options = nil)
    url = all_options.is_a?(Array) ? all_options[0].merge({:only_path => false}) : "#"

    current_url = url_for(:action => @current_action, :only_path => false)
    html_options = {}

    if all_options.is_a?(Array)
      all_options.each do |o|
        if url_for(o.merge({:only_path => false})) == current_url
          #html_options = {:class => "current_page_item"}
          clase = "current_page_item"
          break
        end
      end
    end

    link_to(name, url, html_options)
  end
  
  def menu_actual(all_options = nil)
    resultado = ""
    current_url = url_for(:action => @current_action, :only_path => false)
    if all_options.is_a?(Array)
      all_options.each do |o|
        if url_for(o.merge({:only_path => false})) == current_url
          resultado = "current_page_item"
          break
        end
      end
    end
resultado
  end

#DRY flash messages
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do|type|
      if flash[type]
        messages= "<div id=\"#{type}\">#{flash[type]}</div>"
      end
    end
    messages
  end
  
  def cell(label, value)
    "<tr>
  		<td class='label' nowrap='nowrap'>#{label}</td>
  		<td class='value'>#{value}</td>
  	</tr>"
  end
  
  def cell_with_clase(label, value, clase = nil)
    "<tr>
  		<td class='#{clase}' nowrap='nowrap'><strong>#{label}</strong></td>
  		<td class='value'>#{value}</td>
  	</tr>"
  end
  
  
  def cell_separator
    "<tr>
  		<td colspan='2' class='separator'></td>
  	</tr>"
  end
   
  
  def pertenece_a_mi_o_subordinados?(usuario, subordinados, usuario_propietario_id)
  return true if subordinados.include?(usuario_propietario_id) or usuario.has_role?(:admin)
  end
 
  
  def sort_td_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end

     def sort_link_helper(text, param)
       key = param
       key += "_reverse" if params[:sort] == param
       options = {
           :url => {:action => 'index', :params => params.merge({:sort => key, :page => params[:page], :asunto => params[:asunto]})},
           :update => 'table',
           :before => "$('#spinner').show()",
           :success => "$('#spinner').hide()"
       }
       html_options = {
         :title => "Sort by this field",
         :href => url_for(:action => 'list', :params => params.merge({:sort => key, :page => params[:page], :asunto => params[:asunto]}))
       }
       link_to_remote(text, options, html_options)
     end

end
