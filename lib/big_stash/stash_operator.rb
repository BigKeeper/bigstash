# git stash enhancement module
module BigStash
  # git stash enhancement operator
  class StashOperator
    def stashes
      @stashes
    end

    def initialize(path)
      @stashes = {}
      @path = path
      IO.popen("cd #{@path}; git stash list") { |io|
        io.each do |line|
          items = line.chop.split(/: /)
          @stashes[items.last] = items.first
        end
      }
    end

    def stash(name)
      raise 'Nothing to stash, working tree clean' unless can_stash
      p `cd #{@path}; git stash save -a #{name}`
    end

    def can_stash
      can_stash = true
      clear_flag = 'nothing to commit, working tree clean'
      IO.popen("cd #{@path}; git status") { |io|
        io.each do |line|
          can_stash = false if line.include?clear_flag
        end
      }
      can_stash
    end

    def apply_stash(name)
      stash = @stashes[name]
      raise %Q(Nothing to apply, can not find the stash with name '#{name}') unless stash
      p `cd #{@path}; git stash apply #{stash}`
    end

    def stash_for_name(name)
      @stashes[name]
    end

    private :can_stash
  end
end

# Test
p BigStash::StashOperator.new('/Users/mmoaay/Documents/eleme/LPDTeamiOS').stashes
# p BigStash::StashOperator.new('/Users/mmoaay/Documents/eleme/LPDTeamiOS').stash('feature/bugfix_zhyd_weibo_sdk')
p BigStash::StashOperator.new('/Users/mmoaay/Documents/eleme/LPDTeamiOS').stash_for_name('hahaha')
p BigStash::StashOperator.new('/Users/mmoaay/Documents/eleme/LPDTeamiOS').apply_stash('hahaha')
