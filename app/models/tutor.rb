class Tutor < ApplicationRecord
    has_one_attached :picture
    searchkick
end
