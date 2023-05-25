package odd

import (
	"fmt"
	"log"
	"runtime/debug"

	"github.com/yashodhanmohan/go-multi-module-ci-cd/packages/even"
)

func IsOdd(i int) bool {

	buildInfo, ok := debug.ReadBuildInfo()
	if !ok {
		log.Printf("Failed to read build info.")
		return false
	}

	for _, dep := range buildInfo.Deps {
		log.Printf("[Package/odd] Dep: %+v\n", dep)
	}

	log.Printf("[Package/odd] Go Version: %s, Build version: %s, Main path: %s, Main sum: %s", buildInfo.GoVersion, buildInfo.Main.Version, buildInfo.Main.Path, buildInfo.Main.Sum)

	fmt.Println("[Package/odd] IsOdd function called...")

	return !even.IsEven(i)
}
