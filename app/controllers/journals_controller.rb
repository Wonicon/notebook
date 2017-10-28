require_relative 'common.rb'

class JournalsController < ApplicationController
  before_action :set_active, only: [:index]

  def index
    sid = params[:subject_id]
    if sid
      @subject = Subject.find(sid)
      @journals = @subject.journals
    else
      @journals = Journal.all
        .group_by{ |j| j.date }
        .to_a
        .sort_by{ |e| e[0] }
        .reverse
    end
  end

  def create
    subject = Subject.find(params[:subject_id])
    journal = subject.journals.new(journal_params)
    session[:current_subject_page_tab] = 'journals'
    if journal.save
      redirect_back fallback_location: root_path
    else
      report_error(journal)
    end
  end

  def edit
    @journal = Journal.find(params[:id])
    render partial: 'edit', layout: false
  end

  def update
    @journal = Journal.find(params[:id])
    @journal.update(params.require(:journal).permit(:content))
    render plain: helpers.markdown(@journal.content)
  end

  def destroy
    journal = Journal.find(params[:id])
    journal.destroy
    session[:current_subject_page_tab] = 'journals'
    redirect_back fallback_location: root_path
  end

  private
  def journal_params
    params.require(:journal).permit(:content, :date)
  end

  private
  def set_active
    session[:current_controller] = 'Journals'
  end
end
