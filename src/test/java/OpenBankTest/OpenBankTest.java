package OpenBankTest;

import com.intuit.karate.junit5.Karate;

class OpenBankTest {
    @Karate.Test
    Karate runOpenBankFeature() {
        return Karate.run(
            "classpath:features/Autenticacion.feature",
            "classpath:features/RegistroUsuario.feature"
            );
    }
}



