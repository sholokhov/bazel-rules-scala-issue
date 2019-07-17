`bazel build //scala-app:scala_app_binary`

Fails with:
```
/BUILD.bazel:4:1: scala @io_bazel_rules_scala//scala-app:messages_proto-fast failed (Exit 1) scalac failed: error executing command bazel-out/host/bin/external/io_bazel_rules_scala/src/java/io/bazel/rulesscala/scalac/scalac @bazel-out/darwin-fastbuild/bin/scala-app/messages_proto-fast_scalac_worker_input

Use --sandbox_debug to see verbose messages from the sandbox
bazel-out/darwin-fastbuild/bin/scala-app/tmp2998821839141030412/org/example/AuthenticatedData.scala:7: error: object converters is not a member of package org.example
import org.example.converters.ProtobufWrappers._
                   ^

```

Seems like after switching on aspect-based protobuf compilation in `rules_scala` it's not longer possible to depend on
`scala_library` so it breaks custom type mapping.