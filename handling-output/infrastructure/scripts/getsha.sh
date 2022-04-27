#!/bin/bash
set -e
echo '{"value":"'"$(git rev-parse --short HEAD)"'"}'