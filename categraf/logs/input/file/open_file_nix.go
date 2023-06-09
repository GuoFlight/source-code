//go:build !no_logs && !windows

// Unless explicitly stated otherwise all files in this repository are licensed
// under the Apache License Version 2.0.
// This product includes software developed at Datadog (https://www.datadoghq.com/).
// Copyright 2016-present Datadog, Inc.

package file

import (
	"os"
)

// openFile opens a file with the standard Open method on *nix OSes
func openFile(path string) (*os.File, error) {
	return os.Open(path)
}
