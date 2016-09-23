Fabricator(:user) do
  name 'Don Juan'
  provider 'twitter'
  uid (Fabricate.sequence(:uid))
end
