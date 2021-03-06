#-- copyright
# OpenProject Backlogs Plugin
#
# Copyright (C)2013-2014 the OpenProject Foundation (OPF)
# Copyright (C)2011 Stephan Eckardt, Tim Felgentreff, Marnen Laibow-Koser, Sandro Munda
# Copyright (C)2010-2011 friflaj
# Copyright (C)2010 Maxime Guilbot, Andrew Vit, Joakim Kolsjö, ibussieres, Daniel Passos, Jason Vasquez, jpic, Emiliano Heyns
# Copyright (C)2009-2010 Mark Maglana
# Copyright (C)2009 Joe Heck, Nate Lowrie
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 3.
#
# OpenProject Backlogs is a derivative work based on ChiliProject Backlogs.
# The copyright follows:
# Copyright (C) 2010-2011 - Emiliano Heyns, Mark Maglana, friflaj
# Copyright (C) 2011 - Jens Ulferts, Gregor Schmidt - Finn GmbH - Berlin, Germany
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe 'Work packages having story points', type: :feature, js: true do
  before do
    allow(User).to receive(:current).and_return current_user
    allow(Setting).to receive(:plugin_openproject_backlogs).and_return('points_burn_direction' => 'down',
                                                                       'wiki_template'         => '',
                                                                       'card_spec'             => 'Sattleford VM-5040',
                                                                       'story_types'           => [story_type.id.to_s],
                                                                       'task_type'             => task_type.id.to_s)
  end

  let(:current_user) { FactoryGirl.create(:admin) }
  let(:project) { FactoryGirl.create(:project) }
  let(:status) { FactoryGirl.create :default_status }
  let(:story_type) { FactoryGirl.create(:type_feature) }
  let(:task_type) { FactoryGirl.create(:type_feature) }

  describe 'showing the story points on the work package show page' do
    let(:story_points) { 42 }
    let(:story_with_sp) {
      FactoryGirl.create(:story,
                         type: story_type,
                         author: current_user,
                         project: project,
                         status: status,
                         story_points: story_points)
    }

    it 'should be displayed' do
      wp_page = Pages::FullWorkPackage.new(story_with_sp)

      wp_page.visit!

      expect(page).to have_selector('#work-package-storyPoints', text: story_points)

      wp_page.ensure_page_loaded
    end
  end
end
