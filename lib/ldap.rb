require 'rubygems'
require 'net/ldap'

$SERVER = 'example.com'
$PORT = 389
$DN ='dc=example,dc=com'
$BASE = 'ou=People,'.concat($DN)
$PASSWORD = 'password'

module LDAPAction
  def getML(username)

    # ml list
    mllist = []
    # Connet to LDAP
    conn = Net::LDAP.new :host => $SERVER,
                         :port => $PORT,
                         :auth => {
                             :method => :simple,
                             :username => "cn=Manager,".concat($DN),
                             :password => $PASSWORD
                         }

    conn.open do |ldap|
      treebase = $BASE
      filter = Net::LDAP::Filter.eq("uid", username)
      attrs = ["title"]
      ldap.search(:base => treebase, :filter => filter, :attributes => attrs, :return_result => false ) do |entry|
        entry.each do |attr, values|
          values.each do |value|
            if /^ml-/ =~ value then
              ml = value.sub(/^ml-/,"").sub(/-admin$/,"")
              mllist << ml
            elsif /^uid=/ =~ value then
            else
            end
          end
        end
      end
    end

    # check ml
    if mllist.length > 0 then
      return mllist
    else
      return false
    end
  end
end

class Action
  include LDAPAction

  def initialize()
    @user = ''
    @ml = []
  end

  def setUser(username)
    @user = username
  end

  def listML()
   @ml = getML(@user)
  end

  def getMailingList()
    return @ml
  end

end
