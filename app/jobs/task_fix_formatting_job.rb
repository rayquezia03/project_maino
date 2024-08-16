require 'rake'

class TaskFixFormattingJob < ActiveJob::Base
  queue_as :exporters

  def perform
    Rake::Task['task_fix_formatting_errors:call'].invoke
  end
end