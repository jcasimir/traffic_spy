module TrafficSpy
  class StatsController
    def self.ranked_urls(application_slug)
      (1..5).to_a.collect do |index|
        Page.new(:url   => "http://#{application_slug}.com/blog/#{index}.html",
                 :visits => 25 - index )
      end
    end
  end
end