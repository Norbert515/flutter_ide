
import 'package:kernel/kernel.dart';

/// Because it's not trivial to get the vm dependency
/// I'm adding a mock for the sake of syntax checks
/// When compiling this against the flutter engine the correct
/// classes should be uses

abstract class ProgramTransformer {

  transform(Component component);
}

