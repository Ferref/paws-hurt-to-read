<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

use App\Models\User;

class UserAuthTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    protected function setUp(): void
    {
        parent::setUp();
        $this->setUpFaker();

        $password = $this->faker->password(8);

        $this->validData = [
            'name' => $this->faker->userName,
            'email' => $this->faker->unique()->safeEmail,
            'password' => $password,
            'password_confirmation' => $password,
        ];

        $this->invalidData = [
            'name' => '',
            'email' => 'invalid@email',
            'password' => 'short',
            'password_confirmation' => 'mismatch',
        ];
    }

    protected function tearDown(): void
    {
        parent::tearDown();
    }

    public function testUserCanRegister(): void
    {
        $postData = $this->validData;

        $response = $this->post('/user/register', $postData);

        $response->assertStatus(201);
        $response->assertJsonStructure([
            'message',
            'auth_token',
        ]);

        $this->assertDatabaseHas('users', [
            'email' => $postData['email'],
            'name' => $postData['name'],
        ]);

        $user = User::where('email', $postData['email'])->first();
        $this->assertNotNull($user, 'User not found after registration');

        $this->assertNotEquals($postData['password'], $user->password);
        $this->assertTrue(Hash::check($postData['password'], $user->password));
    }

    public function testInvalidDataCannotRegister(): void
    {
        $postData = $this->invalidData;

        $response = $this->post('/user/register', $postData);

        $response->assertJsonValidationErrors([
            'name',
            'email',
            'password',
        ]);

        $response->assertStatus(422);
    }
}
