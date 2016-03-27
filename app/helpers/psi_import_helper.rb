module PsiImportHelper
  def self.format_crew_name(name)
    @flname = name.gsub(" ","").split(",") #gsub not combined with split as nbsp might not exist
    return @flname[1] + " " + @flname[0]
  end
end
