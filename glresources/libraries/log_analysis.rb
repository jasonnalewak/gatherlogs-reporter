class LogAnalysis < Inspec.resource(1)
  name 'log_analysis'
  desc 'Parse log files to find issues'

  attr_accessor :logfile, :grep_expr
  def initialize(log, expr)
    @grep_expr = expr
    @logfile = log
    @messages = read_content
  end

  def hits
    @messages.count
  end

  def exists?
    hits > 0
  end

  def to_s
    "log_analysis(#{grep_expr})"
  end

  private

  def read_content
    inspec.command("grep \"#{grep_expr}\" #{logfile}").stdout.split("\n")
  end
end