require 'spec_helper'

describe Registration do
  it { should belong_to(:user) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
end
