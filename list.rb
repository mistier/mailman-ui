#!/usr/local/bin/ruby
require 'erb'
require 'cgi'
require './lib/ldap.rb'

cgi = CGI.new

ml = LDAPAction.getML cgi.remote_user

content = <<EOS
<html>
  <head>
  </head>
  <body>
    <h1>Welcome <%= cgi.remote_user %> </h1>
    <% if ml %>
    <table>
      <tr>
        <th> mailling list </th>
      </tr>
      <% ml.each do |mail| %>
        <tr><td><%= mail %></td></tr>
      <% end %>
     </table>
    <% else %>
      <h2> no data </h2>
    <% end %>
  </body>
EOS

html = ERB.new(content)
cgi.out({'charset'=> 'utf-8' }) { html.result(binding) }
