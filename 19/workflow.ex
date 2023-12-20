defmodule Workflow do
  @clause_ex "(?<clause>x|m|a|s<|>\d+):(?<yes_clause>A|R|[\w<>]*),(?<no_clause>A|R|[\w<>]*)}"

  def clause_template(name, clause, yes_clause, no_clause) do
    """
    def #{name}(x, m, a, s) do
      if (#{clause}) do
        #{yes_clause}
      else
        #{no_clause}
      end
    end
  """
  end

  def parse_clause(clause) do
    Regex.named_captures(~r/(?<name>\w+){(?<clause>(x|m|a|s)(<|>)\d+):(?<yes_clause>(\w+|A|R)),(?<no_clause>[\w:,<>]+)/, clause)
  end

  def write_workflows(workflows) do
    File.write("workflows.ex", "defmodule Work do #{workflows} end")
  end
end
