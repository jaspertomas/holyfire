module ApplicationHelper
  def radiobuttonset(options={})
    output=""
    (0..options[:values].size-1).each do |i|
      output += radio_button_tag(options[:name], options[:keys][i], options[:field]==options[:keys][i]) + "#{options[:values][i]}\n"
    end
    output.html_safe
  end
end
