require 'rubygems'
require 'net/ldap'

$SERVER = 'example.com'
$PORT = 389
$DN ='dc=example,dc=com'
$BASE = 'ou=People,'.concat($DN)
$PASSWORD = 'password'

module LDAPAction
  def getML(username)
    
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
        if entry.attribute_names.include?(:title) then
          return entry.title.map{|value| value.sub(/^ml-/,"").sub(/-admin$/,"")}
        else
          return false
        end
      end
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

  def listML
    @ml = getML(@user)
  end

  def getMailingList
    return @ml
  end

  def checkMaillingList
    if @ml then
      return true
    else
      return false
    end
  end
