class TweetsController < ApplicationController

				def index
								@results = []
								@errors = []
								if request.post?
												if params[:search_tag] && params[:search_tag].empty?
																@errors << "please enter a hash-tag to search"
																render :index
												else
												search_tag = "#"+ params[:search_tag].to_s.gsub(/\#/,'')
												count= params[:search_count].to_i
												@results = search_tweets(search_tag,count)
												end	
								end
				end

				private
				def search_tweets(htag,cnt)
								res = []
								TweetStream::Client.new.track(htag) do |t|
												res << t
												p "collected tweets -" + res.size.to_s	
												break if res.size >= cnt
								end
								return res
				end
end

