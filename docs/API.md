# 🔌 PickleUp API Specification

## Base URL
```
Production: https://api.pickleup.app/v1
Staging: https://staging-api.pickleup.app/v1
```

## Authentication

All authenticated endpoints require a Bearer token:
```
Authorization: Bearer <jwt_token>
```

---

## Courts API

### GET /courts
Find nearby courts with optional filters.

**Query Parameters**:
- `lat` (required): Latitude
- `lng` (required): Longitude
- `radius` (optional): Search radius in meters (default: 5000, max: 50000)
- `type` (optional): `outdoor`, `indoor`, `mixed`
- `has_lights` (optional): boolean
- `is_free` (optional): boolean
- `open_now` (optional): boolean

**Response**:
```json
{
  "courts": [
    {
      "id": "uuid",
      "name": "Bell Park Courts",
      "address": "123 Main St",
      "location": {"lat": 40.7128, "lng": -74.0060},
      "type": "outdoor",
      "surface": "concrete",
      "has_lights": true,
      "is_free": true,
      "courts_count": 4,
      "distance_m": 1250,
      "crowding": {
        "level": "moderate",
        "active_checkins": 6,
        "updated_at": "2025-11-11T17:30:00Z"
      },
      "verified": true
    }
  ],
  "total": 15
}
```

### POST /courts/{id}/checkins
Start a check-in at a court.

**Request Body**:
```json
{
  "duration_min": 60,
  "location": {"lat": 40.7128, "lng": -74.0060}
}
```

**Response**:
```json
{
  "checkin_id": "uuid",
  "expires_at": "2025-11-11T18:30:00Z",
  "crowding": {
    "level": "busy",
    "active_checkins": 9
  }
}
```

---

## Ladders API

### POST /ladders
Create a new ladder.

**Request Body**:
```json
{
  "name": "Downtown Summer League",
  "format": "doubles",
  "season_start": "2025-06-01",
  "season_end": "2025-08-31",
  "home_courts": ["court-uuid-1", "court-uuid-2"],
  "visibility": "public"
}
```

**Response**:
```json
{
  "id": "ladder-uuid",
  "name": "Downtown Summer League",
  "invite_code": "ABC123",
  "created_at": "2025-11-11T17:00:00Z"
}
```

### POST /ladders/{id}/matchmaker/run
Generate matches for the ladder.

**Request Body**:
```json
{
  "week_start": "2025-11-18",
  "auto_approve": false
}
```

**Response**:
```json
{
  "matches": [
    {
      "id": "match-uuid",
      "team_a": ["user-1", "user-2"],
      "team_b": ["user-3", "user-4"],
      "proposed_slots": [
        {
          "start_at": "2025-11-18T18:00:00Z",
          "court_id": "court-uuid"
        }
      ]
    }
  ],
  "total": 8
}
```

---

## Matches API

### POST /matches/{id}/result
Submit match result.

**Request Body**:
```json
{
  "sets": [
    {"team_a": 11, "team_b": 9},
    {"team_a": 11, "team_b": 7}
  ],
  "winner": "team_a"
}
```

**Response**:
```json
{
  "result_id": "result-uuid",
  "status": "pending_confirmation",
  "confirmation_required_from": ["user-3", "user-4"]
}
```

---

## Notifications API

### GET /users/me/notifications
Get notification history.

**Query Parameters**:
- `limit` (optional): default 20, max 100
- `offset` (optional): default 0
- `unread_only` (optional): boolean

**Response**:
```json
{
  "notifications": [
    {
      "id": "notif-uuid",
      "type": "match_scheduled",
      "title": "New Match Tomorrow",
      "body": "Your match vs. Jamie starts at 6 PM",
      "data": {"match_id": "match-uuid"},
      "read": false,
      "created_at": "2025-11-11T17:00:00Z"
    }
  ]
}
```

---

## Error Responses

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request parameters",
    "details": [
      {"field": "duration_min", "message": "Must be 30, 60, or 90"}
    ]
  }
}
```

**Error Codes**:
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `429` - Rate Limit Exceeded
- `500` - Internal Server Error
