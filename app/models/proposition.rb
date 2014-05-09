class Proposition < ActiveRecord::Base

  def to_ngrams n
    description.normalize.split.each_cons(n).map { |c| c.join ' ' }
  end

  class << self
    def redis
      $redis
    end

    def gramize
      # keys = Proposition.select('distinct(YEAR(created_at))')
      # redis.del(*keys)
      (1..3).each do |n|
        Proposition.where("description like '%lorem%'").each do |prop|
          key = n
          grams = prop.to_ngrams(n)
binding.pry
          grams.each { |g| redis.zincrby(key, 1, g) }
        end        
      end
    end

    def query q
      q = q.normalize
      key = q.split.size

      [redis.zscore(key, q)]
    end
  end
    
end

class String
  def normalize
    self.downcase.squish
  end
end
