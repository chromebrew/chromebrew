module Docopt
  VERSION = '0.6.0'
end
module Docopt
  class DocoptLanguageError < SyntaxError
  end

  class Exit < RuntimeError
    def self.usage
      @@usage
    end

    def self.set_usage(usage)
      @@usage = usage ? usage : ''
    end

    def message
      @@message
    end

    def initialize(message='')
      @@message = (message + "\n" + @@usage).strip
    end
  end

  class Pattern
    attr_accessor :children

    def ==(other)
      return self.inspect == other.inspect
    end

    def to_str
      return self.inspect
    end

    def dump
      puts ::Docopt::dump_patterns(self)
    end

    def fix
      fix_identities
      fix_repeating_arguments
      return self
    end

    def fix_identities(uniq=nil)
      if not instance_variable_defined?(:@children)
        return self
      end
      uniq ||= flat.uniq

      @children.each_with_index do |c, i|
        if not c.instance_variable_defined?(:@children)
          if !uniq.include?(c)
            raise RuntimeError
          end
          @children[i] = uniq[uniq.index(c)]
        else
          c.fix_identities(uniq)
        end
      end
    end

    def fix_repeating_arguments
      either.children.map { |c| c.children }.each do |case_|
        case_.select { |c| case_.count(c) > 1 }.each do |e|
          if e.class == Argument or (e.class == Option and e.argcount > 0)
            if e.value == nil
              e.value = []
            elsif e.value.class != Array
              e.value = e.value.split
            end
          end
          if e.class == Command or (e.class == Option and e.argcount == 0)
            e.value = 0
          end
        end
      end

      return self
    end

    def either
      ret = []
      groups = [[self]]
      while groups.count > 0
        children = groups.shift
        types = children.map { |c| c.class }

        if types.include?(Either)
          either = children.select { |c| c.class == Either }[0]
          children.slice!(children.index(either))
          for c in either.children
            groups << [c] + children
          end
        elsif types.include?(Required)
          required = children.select { |c| c.class == Required }[0]
          children.slice!(children.index(required))
          groups << required.children + children

        elsif types.include?(Optional)
          optional = children.select { |c| c.class == Optional }[0]
          children.slice!(children.index(optional))
          groups << optional.children + children

        elsif types.include?(AnyOptions)
          anyoptions = children.select { |c| c.class == AnyOptions }[0]
          children.slice!(children.index(anyoptions))
          groups << anyoptions.children + children

        elsif types.include?(OneOrMore)
          oneormore = children.select { |c| c.class == OneOrMore }[0]
          children.slice!(children.index(oneormore))
          groups << (oneormore.children * 2) + children

        else
          ret << children
        end
      end

      args = ret.map { |e| Required.new(*e) }
      return Either.new(*args)
    end
  end


  class ChildPattern < Pattern
    attr_accessor :name, :value

    def initialize(name, value=nil)
      @name = name
      @value = value
    end

    def inspect()
      "#{self.class.name}(#{self.name}, #{self.value})"
    end

    def flat(*types)
      if types.empty? or types.include?(self.class)
        [self]
      else
        []
      end
    end


    def match(left, collected=nil)
      collected ||= []
      pos, match = self.single_match(left)
      if match == nil
        return [false, left, collected]
      end

      left_ = left.dup
      left_.slice!(pos)

      same_name = collected.select { |a| a.name == self.name }
      if @value.is_a? Array or @value.is_a? Integer
        if @value.is_a? Integer
          increment = 1
        else
          increment = match.value.is_a?(String) ? [match.value] : match.value
        end
        if same_name.count == 0
          match.value = increment
          return [true, left_, collected + [match]]
        end
        same_name[0].value += increment
        return [true, left_, collected]
      end
      return [true, left_, collected + [match]]
    end
  end

  class ParentPattern < Pattern
    attr_accessor :children

    def initialize(*children)
      @children = children
    end

    def inspect
      childstr = self.children.map { |a| a.inspect }
      return "#{self.class.name}(#{childstr.join(", ")})"
    end

    def flat(*types)
      if types.include?(self.class)
        [self]
      else
        self.children.map { |c| c.flat(*types) }.flatten
      end
    end
  end

  class Argument < ChildPattern

    def single_match(left)
      left.each_with_index do |p, n|
        if p.class == Argument
          return [n, Argument.new(self.name, p.value)]
        end
      end
      return [nil, nil]
    end

    def self.parse(class_, source)
      name = /(<\S*?>)/.match(source)[0]
      value = /\[default: (.*)\]/i.match(source)
      class_.new(name, (value ? value[0] : nil))
    end
  end


  class Command < Argument
    def initialize(name, value=false)
      @name = name
      @value = value
    end

    def single_match(left)
      left.each_with_index do |p, n|
        if p.class == Argument
          if p.value == self.name
            return n, Command.new(self.name, true)
          else
            break
          end
        end
      end
      return [nil, nil]
    end
  end


  class Option < ChildPattern
    attr_reader :short, :long
    attr_accessor :argcount

    def initialize(short=nil, long=nil, argcount=0, value=false)
      unless [0, 1].include? argcount
        raise RuntimeError
      end

      @short, @long = short, long
      @argcount, @value = argcount, value

      if value == false and argcount > 0
        @value = nil
      else
        @value = value
      end
    end

    def self.parse(option_description)
      short, long, argcount, value = nil, nil, 0, false
      options, _, description = option_description.strip.partition('  ')

      options = options.gsub(',', ' ').gsub('=', ' ')

      for s in options.split
        if s.start_with?('--')
          long = s
        elsif s.start_with?('-')
          short = s
        else
          argcount = 1
        end
      end
      if argcount > 0
        matched = description.scan(/\[default: (.*)\]/i)
        value = matched[0][0] if matched.count > 0
      end
      new(short, long, argcount, value)
    end

    def single_match(left)
      left.each_with_index do |p, n|
        if self.name == p.name
          return [n, p]
        end
      end
      return [nil, nil]
    end

    def name
      return self.long ? self.long : self.short
    end

    def inspect
      return "Option(#{self.short}, #{self.long}, #{self.argcount}, #{self.value})"
    end
  end

  class Required < ParentPattern
    def match(left, collected=nil)
      collected ||= []
      l = left
      c = collected

      for p in self.children
        matched, l, c = p.match(l, c)
        if not matched
          return [false, left, collected]
        end
      end
      return [true, l, c]
    end
  end

  class Optional < ParentPattern
    def match(left, collected=nil)
      collected ||= []
      for p in self.children
        m, left, collected = p.match(left, collected)
      end
      return [true, left, collected]
    end
  end

  class AnyOptions < Optional
  end

  class OneOrMore < ParentPattern
    def match(left, collected=nil)
      if self.children.count != 1
        raise RuntimeError
      end

      collected ||= []
      l = left
      c = collected
      l_ = nil
      matched = true
      times = 0
      while matched
        # could it be that something didn't match but changed l or c?
        matched, l, c = self.children[0].match(l, c)
        times += (matched ? 1 : 0)
        if l_ == l
          break
        end
        l_ = l
      end
      if times >= 1
        return [true, l, c]
      end
      return [false, left, collected]
    end
  end

  class Either < ParentPattern
    def match(left, collected=nil)
      collected ||= []
      outcomes = []
      for p in self.children
        matched, _, _ = outcome = p.match(left, collected)
        if matched
          outcomes << outcome
        end
      end

      if outcomes.count > 0
        return outcomes.min_by do |outcome|
          outcome[1] == nil ? 0 : outcome[1].count
        end
      end
      return [false, left, collected]
    end
  end

  class TokenStream < Array
    attr_reader :error

    def initialize(source, error)
      if !source
        source = []
      elsif source.class != ::Array
        source = source.split
      end
      super(source)
      @error = error
    end

    def move
      return self.shift
    end

    def current
      return self[0]
    end
  end

  class << self
    def parse_long(tokens, options)
      long, eq, value = tokens.move().partition('=')
      unless long.start_with?('--')
        raise RuntimeError
      end
      value = (eq == value and eq == '') ? nil : value

      similar = options.select { |o| o.long and o.long == long }

      if tokens.error == Exit and similar == []
        similar = options.select { |o| o.long and o.long.start_with?(long) }
      end

      if similar.count > 1
        ostr = similar.map { |o| o.long }.join(', ')
        raise tokens.error, "#{long} is not a unique prefix: #{ostr}?"
      elsif similar.count < 1
        argcount = (eq == '=' ? 1 : 0)
        o = Option.new(nil, long, argcount)
        options << o
        if tokens.error == Exit
          o = Option.new(nil, long, argcount, (argcount == 1 ? value : true))
        end
      else
        s0 = similar[0]
        o = Option.new(s0.short, s0.long, s0.argcount, s0.value)
        if o.argcount == 0
          if !value.nil?
            raise tokens.error, "#{o.long} must not have an argument"
          end
        else
          if value.nil?
            if tokens.current().nil?
              raise tokens.error, "#{o.long} requires argument"
            end
            value = tokens.move()
          end
        end
        if tokens.error == Exit
          o.value = (!value.nil? ? value : true)
        end
      end
      return [o]
    end

    def parse_shorts(tokens, options)
      token = tokens.move()
      unless token.start_with?('-') && !token.start_with?('--')
        raise RuntimeError
      end
      left = token[1..-1]
      parsed = []
      while left != ''
        short, left = '-' + left[0], left[1..-1]
        similar = options.select { |o| o.short == short }
        if similar.count > 1
          raise tokens.error, "#{short} is specified ambiguously #{similar.count} times"
        elsif similar.count < 1
          o = Option.new(short, nil, 0)
          options << o
          if tokens.error == Exit
            o = Option.new(short, nil, 0, true)
          end
        else
          s0 = similar[0]
          o = Option.new(short, s0.long, s0.argcount, s0.value)
          value = nil
          if o.argcount != 0
            if left == ''
              if tokens.current().nil?
                raise tokens.error, "#{short} requires argument"
              end
              value = tokens.move()
            else
              value = left
              left = ''
            end
          end
          if tokens.error == Exit
            o.value = (!value.nil? ? value : true)
          end
        end
        parsed << o
      end
      return parsed
    end


    def parse_pattern(source, options)
      tokens = TokenStream.new(source.gsub(/([\[\]\(\)\|]|\.\.\.)/, ' \1 '), DocoptLanguageError)

      result = parse_expr(tokens, options)
      if tokens.current() != nil
        raise tokens.error, "unexpected ending: #{tokens.join(" ")}"
      end
      return Required.new(*result)
    end


    def parse_expr(tokens, options)
      seq = parse_seq(tokens, options)
      if tokens.current() != '|'
        return seq
      end
      result = seq.count > 1 ? [Required.new(*seq)] : seq

      while tokens.current() == '|'
        tokens.move()
        seq = parse_seq(tokens, options)
        result += seq.count > 1 ? [Required.new(*seq)] : seq
      end
      return result.count > 1 ? [Either.new(*result)] : result
    end

    def parse_seq(tokens, options)
      result = []
      stop = [nil, ']', ')', '|']
      while !stop.include?(tokens.current)
        atom = parse_atom(tokens, options)
        if tokens.current() == '...'
          atom = [OneOrMore.new(*atom)]
          tokens.move()
        end
        result += atom
      end
      return result
    end

    def parse_atom(tokens, options)
      token = tokens.current()
      result = []

      if ['(' , '['].include? token
        tokens.move()
        if token == '('
          matching = ')'
          pattern = Required
        else
          matching = ']'
          pattern = Optional
        end
        result = pattern.new(*parse_expr(tokens, options))
        if tokens.move() != matching
          raise tokens.error, "unmatched '#{token}'"
        end
        return [result]
      elsif token == 'options'
        tokens.move()
        return [AnyOptions.new]
      elsif token.start_with?('--') and token != '--'
        return parse_long(tokens, options)
      elsif token.start_with?('-') and not ['-', '--'].include? token
        return parse_shorts(tokens, options)
      elsif token.start_with?('<') and token.end_with?('>') or (token.upcase == token && token.match(/[A-Z]/))
        return [Argument.new(tokens.move())]
      else
        return [Command.new(tokens.move())]
      end
    end

    def parse_argv(tokens, options, options_first=false)
      parsed = []
      while tokens.current() != nil
        if tokens.current() == '--'
          return parsed + tokens.map { |v| Argument.new(nil, v) }
        elsif tokens.current().start_with?('--')
          parsed += parse_long(tokens, options)
        elsif tokens.current().start_with?('-') and tokens.current() != '-'
          parsed += parse_shorts(tokens, options)
        elsif options_first
          return parsed + tokens.map { |v| Argument.new(nil, v) }
        else
          parsed << Argument.new(nil, tokens.move())
        end
      end
      return parsed
    end

    def parse_defaults(doc)
      split = doc.split(/^ *(<\S+?>|-\S+?)/).drop(1)
      split = split.each_slice(2).reject { |pair| pair.count != 2 }.map { |s1, s2| s1 + s2 }
      split.select { |s| s.start_with?('-') }.map { |s| Option.parse(s) }
    end

    def printable_usage(doc)
      usage_split = doc.split(/([Uu][Ss][Aa][Gg][Ee]:)/)
      if usage_split.count < 3
        raise DocoptLanguageError, '"usage:" (case-insensitive) not found.'
      end
      if usage_split.count > 3
        raise DocoptLanguageError, 'More than one "usage:" (case-insensitive).'
      end
      return usage_split.drop(1).join().split(/\n\s*\n/)[0].strip
    end

    def formal_usage(printable_usage)
      pu = printable_usage.split().drop(1)  # split and drop "usage:"

      ret = []
      for s in pu.drop(1)
        if s == pu[0]
          ret << ') | ('
        else
          ret << s
        end
      end

      return '( ' + ret.join(' ') + ' )'
    end

    def dump_patterns(pattern, indent=0)
      ws = " " * 4 * indent
      out = ""
      if pattern.class == Array
        if pattern.count > 0
          out << ws << "[\n"
          for p in pattern
            out << dump_patterns(p, indent+1).rstrip << "\n"
          end
          out << ws << "]\n"
        else
          out << ws << "[]\n"
        end

      elsif pattern.class.ancestors.include?(ParentPattern)
        out << ws << pattern.class.name << "(\n"
        for p in pattern.children
          out << dump_patterns(p, indent+1).rstrip << "\n"
        end
        out << ws << ")\n"

      else
        out << ws << pattern.inspect
      end
      return out
    end

    def extras(help, version, options, doc)
      if help and options.any? { |o| ['-h', '--help'].include?(o.name) && o.value }
        Exit.set_usage(nil)
        raise Exit, doc.strip
      end
      if version and options.any? { |o| o.name == '--version' && o.value }
        Exit.set_usage(nil)
        raise Exit, version
      end
    end

    def docopt(doc, params={})
      default = {:version => nil, :argv => nil, :help => true, :options_first => false}
      params = default.merge(params)
      params[:argv] = ARGV if !params[:argv]

      Exit.set_usage(printable_usage(doc))
      options = parse_defaults(doc)
      pattern = parse_pattern(formal_usage(Exit.usage), options)
      argv = parse_argv(TokenStream.new(params[:argv], Exit), options, params[:options_first])
      pattern_options = pattern.flat(Option).uniq
      pattern.flat(AnyOptions).each do |ao|
        doc_options = parse_defaults(doc)
        ao.children = doc_options.reject { |o| pattern_options.include?(o) }.uniq
      end
      extras(params[:help], params[:version], argv, doc)

      matched, left, collected = pattern.fix().match(argv)
      collected ||= []

      if matched and (left.count == 0)
        return Hash[(pattern.flat + collected).map { |a| [a.name, a.value] }]
      end
      raise Exit
    end
  end
end
