#
# Table Schema
# ------------
# id            - int(11)      - default NULL
# host_name     - varchar(255) - default NULL
# host_email    - varchar(255) - default NULL
# numgsts       - int(11)      - default NULL
# guest_names   - text         - default NULL
# venue         - varchar(255) - default NULL
# location      - varchar(255) - default NULL
# theme         - varchar(255) - default NULL
# when          - datetime     - default NULL
# when_its_over - datetime     - default NULL
# descript      - text         - default NULL
#
class Party < ApplicationRecord
  after_initialize :set_defaults
  before_save :clean_guest_names # AR callbacks are dirty in general, should refactor to a setter

  validate :validations
  validate :must_start_before_it_ends
  validate :must_name_all_guests
  validate :location, length: { minimum: 1, message: "Where is the party?" },
    if: -> { venue.length > 0 }

  %i{host_name host_email venue location theme}.each do |attr|
    validate attr, length: {maximum: 255}
  end

  def must_start_before_it_ends
    if self[:when] > when_its_over
      errors.add("Party cannot start after it ends")
    end
  end

  def must_name_all_guests
    if guest_names.split(',').size != numgsts
      errors.add(:guest_names,"Missing guest name")
    end
  end

  def set_defaults
    self.numgsts ||= 0
  end

  def clean_guest_names
    self.guest_names = self.guest_names.split(',').map do |g|
      g.squeeze!
      names=g.split(' ')
      "#{names[0]} #{names[1..-1].join('_')}"
    end
  end
end
