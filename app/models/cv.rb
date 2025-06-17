class Cv
  include ActiveModel::Model
  
  attr_accessor :name, :title, :github_url, :skills, :about_me, :experience, :education
  
  def self.current
    new(
      name: "Matthew Bootland",
      title: "Software Engineer",
      github_url: "https://github.com/mbootland",
      skills: [
        ["Ruby on Rails", "GoLang", "JavaScript"],
        ["React Native", "TypeScript", "GraphQL / REST"],
        ["DevOps", "Docker", "Kubernetes"]
      ],
      about_me: {
        years_in_japan: calculate_years_in_japan,
        years_programming: calculate_years_programming
      },
      experience: [
        {
          company: "PlayerData",
          location: "Sapporo (Remote)",
          title: "Senior Software Engineer, Product Engineering team",
          period: "Feb 2024 - current",
          description: "PlayerData is a sports data company that provides data and analytics services to sports organizations and teams.",
          tech: ["Ruby on Rails", "PostgreSQL", "GraphQL", "TypeScript", "React Native"]
        },
        # ... other experiences
      ],
      education: [
        {
          institution: "The University of Bradford",
          degree: "MSc Computing",
          period: "Sep 2013 - Jul 2016",
          details: "Modules: Software Development, Databases, Computer Architecture & Systems, Advanced Software Engineering, etc"
        },
        {
          institution: "The University of Sheffield",
          degree: "BA East Asian Studies",
          period: "Sep 2008 - Jul 2012"
        }
      ]
    )
  end

  private

  def self.calculate_years_in_japan
    move_to_japan_start_date = DateTime.new(2016, 9)
    DateTime.now.year - move_to_japan_start_date.year
  end

  def self.calculate_years_programming
    programming_start_date = DateTime.new(2015, 6)
    DateTime.now.year - programming_start_date.year - 2
  end
end