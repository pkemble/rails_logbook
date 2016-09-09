module PsiImportHelper
  def self.format_crew_name(name)
    @flname = name.gsub(" ","").gsub(/\(.+\)/, "").split(",") #gsub not combined with split as nbsp might not exist
    return @flname[1] + " " + @flname[0]
  end

  def tz_normalize
    #TODO this should remove the zulu time - need to check 61.51 and see what
    # the tolerances are for what a "day" of flying consists of.
  end
end
