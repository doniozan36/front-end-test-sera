<?php

namespace App\Http\Controllers;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Client;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function login(Request $request)
    {
    	$credentials = $request->only('email', 'password');
		$client = new Client();

        	// $result = $client->post('localhost/back-end-seraa/public/auth/login', $credential);  
        	$result = $client->post('localhost/back-end-seraa/public/auth/login', [
		            'email' => $request->email,
		            'password' => $request->password
			]);
			return $result;

    }
}
