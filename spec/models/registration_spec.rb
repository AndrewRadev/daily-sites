require 'rails_helper'

RSpec.describe Registration do
  it "disallows duplicates" do
    create(:registration, uid: '123', provider: 'twitter')

    expect(build(:registration, uid: '123', provider: 'twitter')).to_not be_valid
    expect(build(:registration, uid: '234', provider: 'twitter')).to be_valid
    expect(build(:registration, uid: '123', provider: 'facebook')).to be_valid
  end

  it "lets us check if the registration data is already there" do
    create(:registration, uid: '123', provider: 'twitter')
    expect(Registration).to be_already_created(uid: '123', provider: 'twitter')
    expect(Registration).to_not be_already_created(uid: '234', provider: 'twitter')
    expect(Registration).to_not be_already_created(uid: '123', provider: 'facebook')
  end
end
