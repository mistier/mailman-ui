require 'rubygems'
require 'net/ldap'

SERVER = 'example.com'
PORT = 389
BASE = 'ou=People,dc=example,dc=com'

conn = Net::LDAP.new :host => SERVER,
                     :port => PORT,
                     :auth => {
                         :method => :simple,
                         :username => "cn=Manager,dc=example,dc=com",
                         :password => "password"
                     }

conn.open do |ldap|
  treebase = BASE
  filter = Net::LDAP::Filter.eq( "uid", ARGV[0] )
  attrs = ["title"]
  ldap.search(:base => treebase, :filter => filter, :attributes => attrs, :return_result => false ) do |entry|
    entry.each do |attr, values|
      values.each do |value|
        if /^ml-/ =~ value
          ml = value.sub(/^ml-/,"").sub(/-admin$/,"")
          puts "#{ml}"
        end
      end
    end
  end
end
