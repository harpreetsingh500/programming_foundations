munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  age = munsters[key]['age']
  if age <= 17
    munsters[key]['age_group'] = 'kid'
  elsif (age >= 18) && (age <= 64)
    munsters[key]['age_group'] = 'adult'
  else
    munsters[key]['age_group'] = 'senior'
  end
end

p munsters