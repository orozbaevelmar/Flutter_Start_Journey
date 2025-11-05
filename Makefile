.DEFAULT_GOAL := list
list:
	@printf "%-20s %s\n" "Target" "Description"
	@printf "%-20s %s\n" "------" "-----------"
	@make -pqR : 2>/dev/null \
			| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
			| sort \
			| egrep -v -e '^[^[:alnum:]]' -e '^$@$$' \
			| xargs -I _ sh -c 'printf "%-20s " _; make _ -nB | (grep -i "^# Help:" || echo "") | tail -1 | sed "s/^# Help: //g"'

.PHONY: test
test:
	@# Help: Run tests
	@flutter test
g:
	@# Help: Install dependencies
	@flutter clean && flutter pub get
apk:
	@# Help: Install dependencies
	@flutter clean && flutter pub get
	@flutter build apk
aab:
	@# Help: Install dependencies
	@flutter clean && flutter pub get
	@flutter build appbundle
get:
	@# Help: Install dependencies
	@flutter pub get
update:
	@# Help: Update dependencies
	@flutter pub upgrade
clean:
	@# Help: Clear project 
	@rm -rf ./build ./.dart_tool
run:
	@# Help: Run app
	@flutter run
check:
	@# Help: Run code checks
	@flutter analyze
build_runner:
	@# Help: Run build_runner
	@flutter packages pub run build_runner build --delete-conflicting-outputs
build_delete:
	@# Help: Run build_runner delete conficts
	@flutter packages pub run build_runner build --delete-conflicting-outputs
gen:
	@# Help: Run build_runner for flutter_gen_runner
	@dart run build_runner build
build_locale:
	@# Help: Run build_runner for flutter_gen for localization
	@flutter gen-l10n

