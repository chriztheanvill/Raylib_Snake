/**
 * @file main.cpp
 * @author Cristian Nieto (chriztheanvill@gmail.com)
 * @brief Just a Game
 * @version 0.1
 * @date 2021-02-09
 *
 * @copyright Copyright (c) 2021
 *
 */

// System
#include <deque>
#include <fmt/color.h>
#include <raylib.h>
#include <raymath.h>

// // For this, in Cmake on Graphics, enable X11
// // #include <X11/Xlib.h>

// NOTE
// DONE
// WARNING
// BUG
// ERROR
// FIXME
// TODO(cris):

/* NOTE to check the program process:
	# Glances
	## Simple
	## glances -612 -t 0.5 -f name:.*program_name*
	## With left panel
	## glances -61 -t 0.5 -f name:.*program_name*
	### Shortcuts:
		q = exit

	# htop
	# htop --filter=program_name
		f10 = exit
*/

const int cellSize { 30 };
const int cellCount { 25 };
const int offset { 75 };

const Color green { 173, 204, 96, 255 };
const Color greendark { 43, 51, 24, 255 };

double lastUpdateTime { };
auto EventTriggered(const double& t_secondsToWait) -> bool
{
	double currentTime = GetTime( );
	if (currentTime - lastUpdateTime >= t_secondsToWait)
	{
		lastUpdateTime = currentTime;
		return true;
	}
	return false;
}

auto ElementInDeque(const Vector2& element, const std::deque<Vector2>& deque)
{
	for (const auto& v : deque)
		if (Vector2Equals(v, element)) return true;

	return false;
}

class Snake
{
  public:
	std::deque<Vector2> body = {
		Vector2 {6, 9},
		Vector2 {5, 9},
		Vector2 {4, 9}
	};
	Vector2 direction { 1, 0 };
	bool addSegment { };

	void Draw( )
	{
		for (const auto& v : body)
		{
			// DrawRectangle(
			//   v.x * cellSize,
			//   v.y * cellSize,
			//   cellSize,
			//   cellSize,
			//   greendark
			// );
			Rectangle segment = Rectangle	//
			  {								//
				offset + v.x * cellSize,
				offset + v.y * cellSize,
				cellSize,
				cellSize
			  };
			DrawRectangleRounded(segment, 0.5, 3, greendark);
		}
	}

	void Update( )
	{
		body.push_front(Vector2Add(body.at(0), direction));
		if (addSegment) addSegment = false;
		else body.pop_back( );
	}

	void Reset( )
	{
		body = {
			Vector2 {6, 9},
			Vector2 {5, 9},
			Vector2 {4, 9}
		};
		direction = { 1, 0 };
	}
};

class Food
{
  public:
	Vector2 position { };
	Texture2D texture { };

	Food(const std::deque<Vector2>& snakeBody)
	{
		Image image = LoadImage("assets/images/AnApple/apple-3155 (6).png");
		texture = LoadTextureFromImage(image);
		UnloadImage(image);
		position = GenerateRandomPosition(snakeBody);
	}

	~Food( ) { UnloadTexture(texture); }

	void Draw( )
	{
		// DrawRectangle(
		//   position.x * cellSize,
		//   position.y * cellSize,
		//   cellSize,
		//   cellSize,
		//   greendark
		// );
		DrawTexture(
		  texture,
		  offset + position.x * cellSize,
		  offset + position.y * cellSize,
		  WHITE
		);
	}

	auto GenerateRandomPosition(const std::deque<Vector2>& snakeBody) -> Vector2
	{
		auto generateRandomCell = []( )
		{
			return Vector2												 //
			  {
				  static_cast<float>(GetRandomValue(0, cellCount - 1)),
				  static_cast<float>(GetRandomValue(0, cellCount - 1))	 //
			  };
		};

		Vector2 pos = generateRandomCell( );
		while (ElementInDeque(pos, snakeBody))
		{	//
			pos = generateRandomCell( );
		}
		return pos;
	}
};

class Game
{
  public:
	Snake snake { };
	Food food { snake.body };
	bool isRunning { true };
	int score { };

	Sound eatSound;
	Sound wallSound;

	Game( )
	{
		InitAudioDevice( );

		eatSound = LoadSound("assets/sounds/confirmation_001.ogg");
		wallSound = LoadSound("assets/sounds/back_001.ogg");
		SetSoundVolume(eatSound, .2);
		SetSoundVolume(wallSound, .2);
	}

	~Game( )
	{
		UnloadSound(eatSound);
		UnloadSound(wallSound);
		CloseAudioDevice( );
	}

	void Draw( )
	{
		food.Draw( );
		snake.Draw( );
	}

	void Update( )
	{
		if (isRunning)
		{
			snake.Update( );
			CheckCollisionWithFood( );
			CheckCollisionWithEdges( );
			CheckCollisionWithTail( );
		}
	}

	void CheckCollisionWithFood( )
	{
		if (Vector2Equals(snake.body.at(0), food.position))
		{
			food.position = food.GenerateRandomPosition(snake.body);
			snake.addSegment = true;
			score++;
			PlaySound(eatSound);
		}
	}

	void CheckCollisionWithEdges( )
	{
		if (snake.body.at(0).x == cellCount || snake.body.at(0).x == -1)
			GameOver( );
		if (snake.body.at(0).y == cellCount || snake.body.at(0).y == -1)
			GameOver( );
	}

	void GameOver( )
	{
		fmt::print("\nGameOver");
		snake.Reset( );
		food.position = food.GenerateRandomPosition(snake.body);
		isRunning = false;
		score = 0;
		PlaySound(wallSound);
	}

	void CheckCollisionWithTail( )
	{
		std::deque<Vector2> headLessBody = snake.body;
		headLessBody.pop_front( );
		if (ElementInDeque(snake.body.at(0), headLessBody)) { GameOver( ); }
	}
};

auto main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[]) -> int
{
	const int screenWidth = 800;
	const int screenHeight = 450;
	const int FPS = 30;

	const int testSize = 2 * offset + cellSize * cellCount;

	InitWindow(testSize, testSize, "MyGame");
	SetTargetFPS(FPS);

	Game game { };

	while (!WindowShouldClose( ))
	{
		BeginDrawing( );

		// Update
		if (EventTriggered(0.2)) game.Update( );

		// Events
		if (IsKeyPressed(KEY_UP) && game.snake.direction.y != 1)
		{
			game.snake.direction = { 0, -1 };
		}
		else if (IsKeyPressed(KEY_DOWN) && game.snake.direction.y != -1)
		{
			game.snake.direction = { 0, 1 };
		}
		else if (IsKeyPressed(KEY_LEFT) && game.snake.direction.x != 1)
		{
			game.snake.direction = { -1, 0 };
		}
		else if (IsKeyPressed(KEY_RIGHT) && game.snake.direction.x != -1)
		{
			game.snake.direction = { 1, 0 };
		}

		if (!game.isRunning && IsKeyPressed(KEY_SPACE))
		{
			game.isRunning = true;
		}

		// Render
		ClearBackground(green);
		DrawRectangleLinesEx(	//
		  Rectangle				//
		  {
			offset - 5,
			offset - 5,
			cellSize * cellCount + 10,
			cellSize * cellCount + 10	//
		  },
		  5,
		  greendark
		);
		DrawText(
		  "Retro Snake",   //
		  offset - 5,
		  20,
		  40,
		  greendark
		);
		DrawText(
		  TextFormat("Score: %i", game.score),	 //
		  offset - 5,
		  offset + 5 + cellSize * cellCount,
		  40,
		  greendark
		);
		game.Draw( );

		EndDrawing( );
	}

	CloseWindow( );
#ifdef NDEBUG
	fmt::print("\n\n RELEASE!\n");
#else
	fmt::print("\n\n Debug!\n");
#endif

	return 0;
}
