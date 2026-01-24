<?php

namespace App\Http\Controllers;

use App\Models\TicketAttachment;
use Illuminate\Http\Response;

class AttachmentController extends Controller
{
    public function show(TicketAttachment $attachment): Response
    {
        if (!$attachment->file_data) {
            abort(404, 'File tidak ditemukan');
        }

        $fileData = base64_decode($attachment->file_data);

        return response($fileData, 200, [
            'Content-Type' => $attachment->file_type,
            'Content-Disposition' => 'inline; filename="' . $attachment->file_name . '"',
            'Content-Length' => strlen($fileData),
            'Cache-Control' => 'public, max-age=31536000',
        ]);
    }

    public function download(TicketAttachment $attachment): Response
    {
        if (!$attachment->file_data) {
            abort(404, 'File tidak ditemukan');
        }

        $fileData = base64_decode($attachment->file_data);

        return response($fileData, 200, [
            'Content-Type' => $attachment->file_type,
            'Content-Disposition' => 'attachment; filename="' . $attachment->file_name . '"',
            'Content-Length' => strlen($fileData),
        ]);
    }
}
