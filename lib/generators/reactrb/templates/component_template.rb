module Components
  <%- @modules.each do |module_name| %><%= "  "* @indet %>module <%= module_name.camelize %><%- @indet += 1 %>
  <%- end %><%="  "* @indet %>class <%= @file_name %> < React::Component::Base
  <%="  "* @indet %># param :my_param

  <%="  "* @indet %>def render
  <%="  "* @indet %>  #  div do
  <%="  "* @indet %>  #    "Some display code"
  <%="  "* @indet %>  #  end
  <%="  "* @indet %>end
<%="  "* @indet %>end
  <%- @modules.each do %><%- @indet -= 1 %><%="  "* @indet %>end
  <%- end %>end
