`bazel build //...`

Fails with:
```
... creating scalapb files //shared/protocols:C failed (Exit 1)
java.nio.file.FileAlreadyExistsException: external/com_google_protobuf/google/protobuf/timestamp.proto
        at java.base/sun.nio.fs.UnixCopyFile.copy(UnixCopyFile.java:573)
        at java.base/sun.nio.fs.UnixFileSystemProvider.copy(UnixFileSystemProvider.java:254)
        at java.base/java.nio.file.Files.copy(Files.java:1294)
        at scripts.ScalaPBGenerator.$anonfun$setupIncludedProto$1(ScalaPBGenerator.scala:42)
        at scala.collection.immutable.List.foreach(List.scala:392)
        at scripts.ScalaPBGenerator.setupIncludedProto(ScalaPBGenerator.scala:37)
        at scripts.ScalaPBGenerator.processRequest(ScalaPBGenerator.scala:53)
        at io.bazel.rulesscala.worker.GenericWorker.runPersistentWorker(GenericWorker.java:45)
        at io.bazel.rulesscala.worker.GenericWorker.run(GenericWorker.java:111)
        at scripts.ScalaPBWorker$.main(ScalaPBGenerator.scala:26)
        at scripts.ScalaPBWorker.main(ScalaPBGenerator.scala)

```