# encoding: UTF-8

require 'active_support/core_ext/integer/inflections'
#require 'active_support/core_ext/date_time/conversions'

module OrdinalizedFormatting
  def formatted(format = nil, options = {})
    options[:ordinals] = false
    to_ordinalized_s(format, options)
  end

  # @example
  #   Time.now.to_ordinalized_s :long
  #   # => "February 28th, 2006 21:10"
  def to_ordinalized_s(format = nil, options = {})
    return self.to_s if format.nil?

    ordinals = options.delete(:ordinals)
    ordinals = true if ordinals.nil?

    type = self.respond_to?(:sec) ? 'time' : 'date'
    options = options.merge(:raise => true, :object => self, :locale => options[:locale] || I18n.locale)

    format = begin
               options[:format] || I18n.t(:"#{type}.formats.#{format}", options)
             rescue I18n::MissingTranslationData
               case format
               when :time
                 I18n.t(:'time.formats.time', options)
               when :date
                 I18n.t(:'date.formats.default', options)
               else
                 raise
               end
             end

    format.gsub!(/(^|[^-])%d/, '\1_%d_') if ordinals

    I18n.l(self, options.merge({:format => format})).gsub(/_(\d+)_/) { $1.to_i.ordinalize }
  end

  # Gives you a relative date in an attractive format.
  #
  # @param [String] format strftime string used to format a time/date object.
  # @param [String, Symbol] locale An optional value which can be used by
  #   localization plugins
  #
  # @return [String] Ordinalized time/date object.
  #
  # @example
  #    5.days.ago.strftime_ordinalized('%b %d, %Y')
  #    # => "Oct 29th, 2010"
  def strftime_ordinalized(fmt, format=nil)
    strftime(fmt.gsub(/(^|[^-])%d/, '\1_%d_')).gsub(/_(\d+)_/) { $1.to_i.ordinalize }
  end
end
