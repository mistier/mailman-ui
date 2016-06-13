require 'rubygems'
require 'validates_email_format_of'

module ValidationAction

def checkMail(mailaddr)
  result_msg = []

  #validation.
  mailaddr.each do |addr|
    ckmail = ValidatesEmailFormatOf::validate_email_format(addr)
    if ckmail == nil
    else
      result_msg.push(addr)
    end
  end
  return result_msg
end
  module_function :checkMail
end
