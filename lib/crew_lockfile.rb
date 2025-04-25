# Based upon the fork of https://github.com/ahoward/lockfile at
# https://github.com/mikisvaz/lockfile/tree/master and the PRs at
# https://github.com/ahoward/lockfile/pulls
# Usage:
#    require_relative '../lib/crew_lockfile'
#    lockfile = CrewLockfile.new 'file.lock'
#    begin
#      lockfile.lock
#      p 42
#    ensure
#      lockfile.unlock
#    end

unless defined?($__crew_lockfile__) || defined?(CrewLockfile)

  require 'socket'
  require 'timeout'
  require 'fileutils'
  require_relative '../lib/color'

  class CrewLockfile
    VERSION = '2.1.9'
    def self.version = CrewLockfile::VERSION
    def version = CrewLockfile::VERSION

    def self.description
      'a ruby library for creating perfect and NFS safe lockfiles'
    end

    class LockError < StandardError; end
    class StolenLockError < LockError; end
    class StackingLockError < LockError; end
    class StatLockError < LockError; end
    class MaxTriesLockError < LockError; end
    class TimeoutLockError < LockError; end
    class NFSLockError < LockError; end
    class UnLockError < LockError; end

    class SleepCycle < Array
      attr_reader :min, :max, :range, :inc

      def initialize(min, max, inc)
        super(min)
        super(max)
        super(inc)
        @min = Float(min)
        @max = Float(max)
        @inc = Float(inc)
        @range = @max - @min
        raise RangeError, "max(#{@max}) <= min(#{@min})" if @max <= @min
        raise RangeError, "inc(#{@inc}) > range(#{@range})" if @inc > @range
        raise RangeError, "inc(#{@inc}) <= 0" if @inc <= 0
        raise RangeError, "range(#{@range}) <= 0" if @range <= 0
        s = @min
        push(s) and s += @inc while s <= @max
        self[-1] = @max if self[-1] < @max
        reset
      end

      def next
        ret = self[@idx]
        @idx = ((@idx + 1) % size)
        ret
      end

      def reset
        @idx = 0
      end
    end

    HOSTNAME = Socket.gethostname

    DEFAULT_RETRIES          = nil    # maximum number of attempts
    DEFAULT_TIMEOUT          = nil    # the longest we will try
    DEFAULT_MAX_AGE          = 3600   # lockfiles older than this are stale
    DEFAULT_SLEEP_INC        = 2      # sleep cycle is this much longer each time
    DEFAULT_MIN_SLEEP        = 2      # shortest sleep time
    DEFAULT_MAX_SLEEP        = 32     # longest sleep time
    DEFAULT_SUSPEND          = 1800   # iff we steal a lock wait this long before we go on
    DEFAULT_REFRESH          = 8      # how often we touch/validate the lock
    DEFAULT_DONT_CLEAN       = false  # iff we leave lock files lying around
    DEFAULT_POLL_RETRIES     = 16     # this many polls makes one 'try'
    DEFAULT_POLL_MAX_SLEEP   = 0.08   # the longest we'll sleep between polls
    DEFAULT_DONT_SWEEP       = false  # if we cleanup after other process on our host
    DEFAULT_DONT_USE_LOCK_ID = false  # if we dump lock info into lockfile

    DEFAULT_DEBUG = ENV['LOCKFILE_DEBUG'] || false

    class << CrewLockfile
      attr_accessor :retries, :max_age, :sleep_inc, :min_sleep, :max_sleep, :suspend, :timeout, :refresh, :debug, :dont_clean, :poll_retries, :poll_max_sleep, :dont_sweep, :dont_use_lock_id

      def init
        @retries          = DEFAULT_RETRIES
        @max_age          = DEFAULT_MAX_AGE
        @sleep_inc        = DEFAULT_SLEEP_INC
        @min_sleep        = DEFAULT_MIN_SLEEP
        @max_sleep        = DEFAULT_MAX_SLEEP
        @suspend          = DEFAULT_SUSPEND
        @timeout          = DEFAULT_TIMEOUT
        @refresh          = DEFAULT_REFRESH
        @dont_clean       = DEFAULT_DONT_CLEAN
        @poll_retries     = DEFAULT_POLL_RETRIES
        @poll_max_sleep   = DEFAULT_POLL_MAX_SLEEP
        @dont_sweep       = DEFAULT_DONT_SWEEP
        @dont_use_lock_id = DEFAULT_DONT_USE_LOCK_ID

        @debug = DEFAULT_DEBUG

        $stdout.sync = true if @debug
        $stderr.sync = true if @debug
      end
    end

    CrewLockfile.init

    attr_reader :klass, :path, :opts, :locked, :thief, :refresher, :dirname, :basename, :clean, :retries, :max_age, :sleep_inc, :min_sleep, :max_sleep, :suspend, :refresh, :timeout, :dont_clean, :poll_retries, :poll_max_sleep, :dont_sweep, :dont_use_lock_id

    attr_accessor :debug

    alias thief? thief
    alias locked? locked
    alias debug? debug

    def self.create(path, *options, &)
      opts = {
        'retries' => 0,
        'min_sleep' => 0,
        'max_sleep' => 1,
        'sleep_inc' => 1,
        'max_age' => nil,
        'suspend' => 0,
        'refresh' => nil,
        'timeout' => nil,
        'poll_retries' => 0,
        'dont_clean' => true,
        'dont_sweep' => false,
        'dont_use_lock_id' => true
      }
      begin
        new(path, opts).lock
      rescue LockError
        raise Errno::EEXIST, path
      end
      File.open(path, *options, &)
    end

    def self.finalizer_proc(file)
      pid = Process.pid
      lambda do |_id|
        File.unlink file if Process.pid == pid
      rescue StandardError
        nil
      end
    end

    def initialize(path, opts = {}, &block)
      @klass = self.class
      @path  = path
      @opts  = opts

      @retries          = getopt 'retries', @klass.retries
      @max_age          = getopt 'max_age', @klass.max_age
      @sleep_inc        = getopt 'sleep_inc', @klass.sleep_inc
      @min_sleep        = getopt 'min_sleep', @klass.min_sleep
      @max_sleep        = getopt 'max_sleep', @klass.max_sleep
      @suspend          = getopt 'suspend', @klass.suspend
      @timeout          = getopt 'timeout', @klass.timeout
      @refresh          = getopt 'refresh', @klass.refresh
      @dont_clean       = getopt 'dont_clean', @klass.dont_clean
      @poll_retries     = getopt 'poll_retries', @klass.poll_retries
      @poll_max_sleep   = getopt 'poll_max_sleep', @klass.poll_max_sleep
      @dont_sweep       = getopt 'dont_sweep', @klass.dont_sweep
      @dont_use_lock_id = getopt 'dont_use_lock_id', @klass.dont_use_lock_id
      @debug            = getopt 'debug', @klass.debug

      @semaphore = Mutex.new

      @sleep_cycle = SleepCycle.new @min_sleep, @max_sleep, @sleep_inc

      @clean    = @dont_clean ? nil : CrewLockfile.finalizer_proc(@path)

      @dirname  = File.dirname @path
      @basename = File.basename @path
      @thief    = false
      @locked   = false
      @refresher = nil

      lock(&block) if block
    end

    ##
    # Executes the given block after acquiring the lock and
    # ensures that the lock is relinquished afterwards.
    #
    def synchronize
      raise ArgumentError, 'block must be given' unless block_given?
      begin
        lock
        yield
      ensure
        unlock
      end
    end

    def lock
      raise StackingLockError, "<#{@path}> is locked!".lightred if @locked

      sweep unless @dont_sweep

      ret = nil

      attempt do
        @sleep_cycle.reset
        create_tmplock do |f|
          Timeout.timeout(@timeout) do
            tmp_path = f.path
            tmp_stat = f.lstat
            n_retries = 0
            trace { "attempting to lock <#{@path}>..." }
            begin
              i = 0
              begin
                trace { "polling attempt <#{i}>..." }
                begin
                  File.link tmp_path, @path
                rescue Errno::ENOENT
                  try_again!
                end
                lock_stat = File.lstat @path
                raise StatLockError, 'stats do not agree'.lightred unless
                  (tmp_stat.rdev == lock_stat.rdev) && (tmp_stat.ino == lock_stat.ino)
                trace { "acquired lock <#{@path}>" }
                @locked = true
              rescue StandardError
                i += 1
                unless i >= @poll_retries
                  t = [rand(@poll_max_sleep), @poll_max_sleep].min
                  trace { "poll sleep <#{t}>..." }
                  sleep t
                  retry
                end
                raise
              end
            rescue StandardError
              n_retries += 1
              trace { "n_retries <#{n_retries}>" }
              case validlock?
              when true
                raise MaxTriesLockError, "surpassed retries <#{@retries}>" if
                  @retries && (n_retries >= @retries)
                trace { 'found valid lock' }
                sleeptime = @sleep_cycle.next
                trace { "sleep <#{sleeptime}>..." }
                sleep sleeptime
              when false
                trace { 'found invalid lock and removing' }
                begin
                  File.unlink @path
                  @thief = true
                  warn "<#{@path}> stolen by <#{Process.pid}> at <#{timestamp}>"
                  trace { 'i am a thief!' }
                rescue Errno::ENOENT => e
                  warn(errmsg(e))
                end
                trace { "suspending <#{@suspend}>" }
                sleep @suspend
              when nil
                raise MaxTriesLockError, "surpassed retries <#{@retries}>" if
                  @retries && (n_retries >= @retries)
              end
              retry
            end
          end
        rescue Timeout::Error
          raise TimeoutLockError, "surpassed timeout <#{@timeout}>"
        end

        if block_given?
          stolen = false
          @refresher = (@refresh ? new_refresher : nil)
          begin
            begin
              ret = yield @path
            rescue StolenLockError
              stolen = true
              raise
            end
          ensure
            begin
              if @refresher&.status
                begin
                  @semaphore.synchronize do
                    @refresher.kill
                  end
                rescue StandardError
                  @refresher.kill
                end
              end
              @refresher = nil
            ensure
              unlock unless stolen
            end
          end
        else
          @refresher = (@refresh ? new_refresher : nil)
          ObjectSpace.define_finalizer self, @clean if @clean
          ret = self
        end
      rescue Errno::ESTALE, Errno::EIO => e
        raise(NFSLockError, errmsg(e))
      end

      return ret
    end

    def sweep
      glob = File.join(@dirname, '.*lck')
      paths = Dir[glob]
      paths.each do |path|
        basename = File.basename path
        pat = /^\s*\.([^_]+)_([^_]+)/o
        if pat.match(basename)
          host = ::Regexp.last_match(1)
          pid = ::Regexp.last_match(2)
        else
          next
        end
        host.gsub!(/^\.+|\.+$/, '')
        quad = host.split '.'
        host = quad.first
        pat = /^\s*#{host}/i
        if pat.match(HOSTNAME) && /^\s*\d+\s*$/.match(pid)
          if alive?(pid)
            trace { "process <#{pid}> on <#{host}> is still alive" }
            trace { "ignoring <#{path}>" }
          else
            trace { "process <#{pid}> on <#{host}> is no longer alive" }
            trace { "sweeping <#{path}>" }
            FileUtils.rm_f path
          end
        else
          trace { "ignoring <#{path}> generated by <#{host}>" }
        end
      rescue StandardError
        next
      end
    rescue StandardError => e
      warn(errmsg(e))
    end

    def alive?(pid)
      pid = Integer(pid.to_s)
      begin
        Process.kill 0, pid
        true
      rescue Errno::ESRCH
        false
      end
    end

    def unlock
      raise UnLockError, "<#{@path}> is not locked!" unless @locked

      if @refresher&.status
        begin
          @semaphore.synchronize do
            @refresher.kill
          end
        rescue StandardError
          @refresher.kill
        end
      end

      @refresher = nil

      begin
        File.unlink @path
      rescue Errno::ENOENT
        raise StolenLockError, @path
      ensure
        @thief = false
        @locked = false
        ObjectSpace.undefine_finalizer self if @clean
      end
    end

    def new_refresher
      Thread.new(Thread.current, @path, @refresh, @dont_use_lock_id) do |thread, path, refresh, dont_use_lock_id|
        loop do
          touch path
          trace { "touched <#{path}> @ <#{Time.now.to_f}>" }
          unless dont_use_lock_id
            txt = nil
            @semaphore.synchronize do
              txt = File.read(path)
            end
            loaded = load_lock_id(txt)
            trace { "loaded <\n#{loaded.inspect}\n>" }
            raise unless loaded == @lock_id
          end
          sleep refresh
        # rescue Exception => e
        rescue StandardError => e
          trace { errmsg e }
          thread.raise StolenLockError
          Thread.exit
        end
      end
    end

    def validlock?
      if @max_age
        begin
          uncache @path
        rescue StandardError
          nil
        end
        begin
          return((Time.now - File.stat(@path).mtime) < @max_age)
        rescue Errno::ENOENT
          return false
        end
      else
        exist = File.exist?(@path)
        return(exist ? true : nil)
      end
    end

    def uncache(file)
      refresh = nil
      begin
        is_a_file = file.is_a?(File)
        path = (is_a_file ? file.path : file.to_s)
        stat = (is_a_file ? file.stat : File.stat(file.to_s))
        refresh = tmpnam(File.dirname(path))
        File.link path, refresh
        File.chmod stat.mode, path
        File.utime stat.atime, stat.mtime, path
      ensure
        begin
          File.unlink refresh if refresh
        rescue Errno::ENOENT => e
          warn(errmsg(e))
        end
      end
    end

    def create_tmplock
      tmplock = tmpnam @dirname
      begin
        create(tmplock) do |f|
          unless dont_use_lock_id
            @lock_id = gen_lock_id
            dumped = dump_lock_id
            trace { "lock_id <\n#{@lock_id.inspect}\n>" }
            f.write dumped
            f.flush
          end
          yield f
        end
      ensure
        if tmplock
          begin
            File.unlink tmplock
          rescue Errno::ENOENT => e
            warn(errmsg(e))
          end
        end
      end
    end

    def gen_lock_id
      { 'host' => HOSTNAME.to_s,
        'pid' => Process.pid.to_s,
        'ppid' => Process.ppid.to_s,
        'time' => timestamp }
    end

    def timestamp
      time = Time.now
      usec = time.usec.to_s
      usec << '0' while usec.size < 6
      "#{time.strftime('%Y-%m-%d %H:%M:%S')}.#{usec}"
    end

    def dump_lock_id(lock_id = @lock_id)
      @host, @pid, @ppid, @time = lock_id.values_at('host', 'pid', 'ppid', 'time')
      format("host: %s\npid: %s\nppid: %s\ntime: %s\n", @host, @pid, @ppid, @time)
    end

    def load_lock_id(buf)
      lock_id = {}
      kv = /([^:]+):(.*)/o
      buf.each_line do |line|
        m = kv.match line
        k = m[1]
        v = m[2]
        next unless m && k && v
        lock_id[k.strip] = v.strip
      end
      lock_id
    end

    def tmpnam(dir, seed = File.basename($PROGRAM_NAME))
      pid = Process.pid
      time = Time.now
      sec = time.to_i
      usec = time.usec
      format('%s%s.%s_%d_%s_%d_%d_%d.lck', dir, File::SEPARATOR, HOSTNAME, pid, seed, sec, usec, rand(sec))
    end

    def create(path)
      umask = nil
      f = nil
      begin
        umask = File.umask 0o22
        f = File.open path, File::WRONLY | File::CREAT | File::EXCL, 0o644
      ensure
        File.umask umask if umask
      end
      return(block_given? ? begin; yield f; ensure; f.close; end : f)
    end

    def touch(path)
      FileUtils.touch path
    end

    def getopt(key, default = nil)
      [key, key.to_s, key.to_s.intern].each do |k|
        return @opts[k] if @opts.key?(k)
      end
      return default
    end

    def to_str
      @path
    end
    alias to_s to_str

    def trace(tracemsg = nil)
      warn(tracemsg || yield) if @debug
    end

    def errmsg(err)
      format("%s (%s)\n%s\n", err.class, err.message, err.backtrace.join("\n")).lightred
    end

    def attempt
      ret = nil
      loop { break unless catch('attempt') { ret = yield } == 'try_again' }
      ret
    end

    def try_again!
      throw 'attempt', 'try_again'
    end
    alias again! try_again!

    def give_up!
      throw 'attempt', 'give_up'
    end
  end

  def CrewLockfile(path, *options, &) # rubocop: disable Naming/MethodName
    CrewLockfile.new(path, *options, &)
  end

  $__crew_lockfile__ = __FILE__
end
