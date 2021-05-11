<template>
  <section style="height: 100%" class="px-8">
    <add-state-dialog ref="addStateDialog" />
    <v-container>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new state'"
        :action="fabAction"
      />
      <h1 class="mb-2 text-center">💡 States 💡</h1>
      <v-divider class="my-4 mb-6"></v-divider>
      <v-row>
        <v-col
          cols="3"
          v-for="state in Object.values(getStates)"
          :key="state.stateId"
        >
          <v-card color="#16a085">
            <v-card-title class="white--text google-sans-regular">
              {{ state.stateName }}
              <v-spacer></v-spacer>
              <v-btn icon @click="_deleteState(state.stateId)">
                <v-icon color="secondary">mdi-delete</v-icon>
              </v-btn>
              <div class="mx-1"></div>
              <v-btn icon @click="_updateState(state)">
                <v-icon color="secondary">mdi-pen</v-icon>
              </v-btn>
            </v-card-title>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import FloatingActionButton from "@/components/Core/FloatingActionButton";
import AddStateDialog from "../components/State/AddStateDialog.vue";
export default {
  name: "States",
  components: {
    FloatingActionButton,
    AddStateDialog,
  },
  computed: {
    ...mapGetters("state", ["getStates"]),
  },
  methods: {
    ...mapActions("state", ["bindStates", "deleteState"]),
    fabAction() {
      this.$refs.addStateDialog.dialog = true;
      console.log("hello");
    },

    _deleteState(stateId) {
      this.deleteState({ stateId });
    },
    _updateState(state) {
      this.$refs.addStateDialog.dialog = true;
      this.$refs.addStateDialog.state = state;
    },
  },
  async created() {
    await this.bindStates();
  },
};
</script>

<style>
</style>