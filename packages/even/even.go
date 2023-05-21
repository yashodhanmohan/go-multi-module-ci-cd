package even

import (
	"fmt"
	"log"
	"runtime/debug"
)

func IsEven(i int) bool {
	buildInfo, ok := debug.ReadBuildInfo()
	if !ok {
		log.Printf("Failed to read build info")
		return false
	}

	for _, dep := range buildInfo.Deps {
		log.Printf("Dep: %+v\n", dep)
	}
	log.Printf("Go Version: %s, Build version: %s, Main path: %s, Main sum: %s", buildInfo.GoVersion, buildInfo.Main.Version, buildInfo.Main.Path, buildInfo.Main.Sum)

	fmt.Println("IsEven function called...")
	return i%2 == 0
}
