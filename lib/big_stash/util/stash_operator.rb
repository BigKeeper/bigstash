module BigStash
  class StashOperator
    def stash(name)
      p `git stash save -a #{name}`
    end

    def apply_stash(name)



    end

    def stash_for_name(name)

    end

    def stashes
      stashes = []
      IO.popen('git stash list') { |io|
        io.each do |line|
          stashes << line
        end
      }
      stashes
    end
  end
end
