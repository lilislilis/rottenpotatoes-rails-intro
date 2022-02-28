class Movie < ActiveRecord::Base
    def self.obtain_ratings
        return self.pluck(:rating).uniq
    end
end
