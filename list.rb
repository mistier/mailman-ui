#!/usr/local/bin/ruby
require 'erb'
require './lib/ldap.rb'

mllist = Action.new
mllist.setUser("username")
mllist.listML

contents = <<EOS
<% mllist.getMailingList.each do |ml| %>
<li><%= ml %></li>
<% end %>
EOS

html = ERB.new(contents)
puts html.result(binding)
