class PartiesController < ApplicationController
  def index
    # originally refactored for style, such as removing if ! (dangerous style) and removal of
    # unnecessary in-memory iterations and allocs, then realized with
    # proper default values, the if branching was completely unnecessary

    order = "#{sort_param} #{sort_direction}"
    @parties = Party.order(order).all
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_param) # strong_params need love too
    @party.when_its_over=@party.when.end_of_day if @party.when_its_over.blank?

    if @party.save
      redirect_to parties_url
    else
      flash[:notice]="Party was incorrect."
      redirect_to new_party_url
    end
  end

  private
  def sort_param
    params.fetch(:sort, 'when')
  end

  def sort_direction
    # addressing the awkward :asc == 'true' returns 'DESC' logic. appeared to be an inverted bug
    params.fetch(:asc, 'false') == 'true' ? 'ASC' : 'DESC'
  end

  def party_param
    params[:party][:numgsts] ||= 0 if params[:party]
    params.require(:party)
  end
end
