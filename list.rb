#!/usr/local/bin/ruby
require 'erb'
require 'cgi'
require './lib/ldap.rb'

cgi = CGI.new

mllist = Action.new
mllist.setUser(cgi.remote_user)
mllist.listML


content = <<EOS
<html>
  <head>
  </head>
  <body>
    <h1>Welcome <%= cgi.remote_user %> </h1>
    <% if mllist.checkMaillingList then %>
    <table>
      <tr>
        <th> mailling list </th>
      </tr>
      <% mllist.getMailingList.each do |ml| %>
        <tr><td><%= ml %></td></tr>
      <% end %>
     </table>
    <% else %>
      <h2> no data </h2>
    <% end %>
  </body>
EOS

html = ERB.new(content)
cgi.out({'charset'=> 'utf-8' }) { html.result(binding) }
