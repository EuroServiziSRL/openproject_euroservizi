//-- copyright
// OpenProject is a project management system.
// Copyright (C) 2012-2014 the OpenProject Foundation (OPF)
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License version 3.
//
// OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
// Copyright (C) 2006-2013 Jean-Philippe Lang
// Copyright (C) 2010-2013 the ChiliProject Team
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// See doc/COPYRIGHT.rdoc for more details.
//++

angular.module('openproject.workPackages.directives')

.directive('costObject', ['$timeout', 'PathHelper', function($timeout, Pathhelper) {
  return {
    restrict: 'E',
    require: '^workPackageField',
    templateUrl: '/templates/plugin-costs/work_packages/cost_object.html',
    link: function(scope, element, attributes, fieldController) {
      scope.$watch(function() {
        return fieldController.state.workPackage;
      }, function(workPackage) {
        scope.workPackage = workPackage;
        scope.costObject = scope.workPackage.embedded.costObject;
        if (scope.costObject) {
          scope.linkToCostObject = scope.costObject.links.staticPath.href;
        }
        $timeout(function() {
          element.find('a').on('click', function(e) {
            e.stopPropagation();
          });
        });
      });

    }
  };
}]);
