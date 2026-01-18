<?php

it('returns a successful response or redirect', function () {
    $response = $this->get('/');

    // Homepage may redirect to login for unauthenticated users
    expect($response->status())->toBeIn([200, 302]);
});
