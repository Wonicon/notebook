require_relative 'common.rb'

class JournalsController < ApplicationController
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
    if journal.save
      redirect_back fallback_location: root_path
    else
      report_error(journal)
    end
  end

  def destroy
    journal = Journal.find(params[:id])
    journal.destroy
    redirect_back fallback_location: root_path
  end

  private
  def journal_params
    params.require(:journal).permit(:content, :date)
  end
end
