#include <catch2/catch.hpp>
#include <iostream>

TEST_CASE("Testing_case") { std::cout << "Testing case_01\n"; }

TEST_CASE("Testing_case_00") { std::cout << "Testing case_00\n"; }

TEST_CASE("Test Main", "[main]") {
	std::cout << "Testing Main\n";
	// STATIC_REQUIRE( );
	// STATIC_REQUIRE(testing_class( ));

	// REQUIRE(false);
}
