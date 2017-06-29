class RankingController < ApplicationController
  def ranking
  	@contest = Contest.find params[:id]
  	@scores = Score.where(contest_id: @contest.id).order(point: :DESC)
  end
end
