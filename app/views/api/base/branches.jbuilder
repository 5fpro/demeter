json.array! @branches do |branch|
  json.branch_code branch.code
  json.bank_branch_code "#{branch.bank.code}#{branch.code}"
  json.address branch.address
  json.name branch.name
end
